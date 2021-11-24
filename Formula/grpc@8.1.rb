# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT81 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.42.0.tgz"
  sha256 "a7b9092534555ea4ea0ea79c1333afd088569eb5865b941a4a610504e387683a"
  head "https://github.com/grpc/grpc.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "e7ca5d5bc3e8ada4ee277e70335856d2902f4933ccee5a4ffdde3369c31e563b"
    sha256 cellar: :any_skip_relocation, big_sur:       "f24021a979f33ca548b35cdae152c445d075de2d8edd5399c1feda663ed8e336"
    sha256 cellar: :any_skip_relocation, catalina:      "b55dcb2c0b1585dec87aa1631b665a74a9fccc4ab886b5d45982d47da54ec4cc"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "5e0df5f2fc002047b0cc1342cea497856ce90a26e3633a1f6a5b836c3a55f1bc"
  end

  depends_on "grpc"

  def install
    Dir.chdir "grpc-#{version}"
    patch_spl_symbols
    safe_phpize
    system "./configure", "--enable-grpc"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
