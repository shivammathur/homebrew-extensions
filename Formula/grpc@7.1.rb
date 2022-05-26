# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT71 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.46.3.tgz"
  sha256 "2aad61230afda3192eedad25be918bda628e6aa18bf1ed7e3bcf1944e6e4f4d5"
  head "https://github.com/grpc/grpc.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "9cbe182127d0120b4527c01bab00a4f86140cb9eecf40f7a187eea252a6de035"
    sha256 cellar: :any_skip_relocation, big_sur:       "95e36d4ab757d365dd2ee0791f64765a313161e31dc92935a0f4fdfecff0db1b"
    sha256 cellar: :any_skip_relocation, catalina:      "78459416f6dd49ee8a286553b45932604c533f074b7733a53aab1f46d2032df4"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "84604d567d9ee4985f3c651c9d33ee50af0fea5c98bc4fc977ec1784dc4a85bd"
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
