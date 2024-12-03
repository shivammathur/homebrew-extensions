# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT70 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.68.0.tgz"
  sha256 "4e022e052d5b7997efd42f3b67f1175dbbb772cfd435570852febc0f569065bb"
  head "https://github.com/grpc/grpc.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "9a4b063306adb871225e1f3d568463238f4ab6e47d447c873b8d6a6a5f58904b"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "a29b1d8ea54107cf7d0f8f4a661901bfea5372d4d8e67eebe0d01387197d17bf"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "ff1cb8677fedb6ad9b4a3d53c69b2c91a1e35f1f52614305e3f91d6426991094"
    sha256 cellar: :any_skip_relocation, ventura:       "ace426833050086dc838e643cb3d2c89ac770dfb69ed9bcf12845a055b38bbd3"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "756db93a4e5d27a641187a2f459db49ab31974a069f868ac308290164f0c82bf"
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
