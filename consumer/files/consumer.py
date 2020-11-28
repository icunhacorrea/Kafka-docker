#!/usr/local/bin/python

from confluent_kafka import Consumer

keys_list = []

def checkDuplicates(total):
    #print(keys_list)
    keysSet = set(keys_list)

    qntDuplicates = len(keys_list) - len(keysSet)

    print("Consumido " + str(total) + " de mensagens.")
    print(str(qntDuplicates) + "de mensagens duplicadas.")
    return

def main():
    c = Consumer({
        'bootstrap.servers': '172.21.0.5:9092,172.21.0.6:9092,172.21.0.7:9092',
        'group.id': 'consumer_check_duplicates',
        'auto.offset.reset': 'earliest'
    })

    c.subscribe(['test-topic'])
    print("Iniciando consumo")

    
    total = 0

    try:
        while True:
            msg = c.poll(1.0)

            if msg is None:
                continue
            if msg.error():
                print("consumer error: {}".format(msg.error()))
                continue

            print("Message received, append key.")
            keys_list.append(msg.key().decode('utf-8'))
            total = total + 1
            #print('Received message: {}'.format(msg.value().decode('utf-8')))
    
    except KeyboardInterrupt:
        pass
    finally:
        checkDuplicates(total)
        c.close()


if __name__ == "__main__":
    main()