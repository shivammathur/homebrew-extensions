# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT81 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.60.0.tgz"
  sha256 "171f490b5426de76b479036c95d4c1ca44bb1a3fb42999e938d2c59fcbceed32"
  head "https://github.com/grpc/grpc.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "f32aa05f38419988433863b2f03dba502a327dd5e30452edcce1f17478bb8ece"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "e3ce9818b81536bde32454f5b43ceefe95e7e5a57d744819961ad084dad59ed5"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "1e9e1271f94b3df7a0c4b552562efbc1b7aece842e66331a9973c2f67a630c0d"
    sha256 cellar: :any_skip_relocation, ventura:        "391e444271a66678fb1669c817214e2a3c618371a29a723aae6da084c0868923"
    sha256 cellar: :any_skip_relocation, monterey:       "e1c9f421d77300d1e058cd4fa3ee26b49b0de2e2818a9ef25a5ecbd2f301d8bb"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "03124ce35b19d4bd8db3bad0cacb6882fd876bbb8c44d24227b5afc7efe10ca6"
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
