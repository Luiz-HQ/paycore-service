import { Injectable } from '@nestjs/common';
import { PrismaService } from '../prisma/prisma.service';
import { CreatePaymentDto } from './dto/create-payment.dto';

@Injectable()
export class PaymentsService {
  constructor(private readonly prisma: PrismaService) {}
  async create(createPaymentDto: CreatePaymentDto) {
    const newPayment = await this.prisma.payment.create({
      data: {
        amount: createPaymentDto.amount,
        referenceId: createPaymentDto.referenceId,
      },
    });

    return newPayment;
  }
}
