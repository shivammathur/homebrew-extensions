# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT80 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.46.3.tgz"
  sha256 "2aad61230afda3192eedad25be918bda628e6aa18bf1ed7e3bcf1944e6e4f4d5"
  head "https://github.com/grpc/grpc.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "d0d9ac7eab021706796acc46877cc90a03d58e49cf28dc02834e45bf55bb79f1"
    sha256 cellar: :any_skip_relocation, big_sur:       "bd12ba4f5c9a8dce0827868cb20f4a4d42b7199c062622b0dd630bb37d77e678"
    sha256 cellar: :any_skip_relocation, catalina:      "8c6ad9f05946e97cdeed3a158dd274de64a9555e010a95e564a7edceabe6b8dd"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "576adc160b5cbcc0497609f0290c92b1c6292fa6e9adf2fa70d5a1edd30b4d75"
  end

  depends_on "grpc"

  def install
    Dir.chdir "grpc-#{version}"
    safe_phpize
    system "./configure", "--enable-grpc"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
