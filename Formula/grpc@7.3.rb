# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT73 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.54.0.tgz"
  sha256 "5ad3c1a046290f901771fc3f557db6c5bdd4208e157f42a0ab061cf10ac0dfa9"
  head "https://github.com/grpc/grpc.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "3c10a93280199030b35a1bbdf44a52bd3582b097cea7d4e90ceb24c8f8ee5688"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "c0bfeeee371d9a223377adbcfc65ee1018bb955f902a4bf68d71efbb4ad5c433"
    sha256 cellar: :any_skip_relocation, monterey:       "e64686ec021831aaabf8c02aa8f9608cc7859b13ac180c750f99344f68769d73"
    sha256 cellar: :any_skip_relocation, big_sur:        "0b437840469cd8be2c09dffc007c6fbc1451cf23a9c5a56a639e22e11a6b12fc"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "815c9a1a8920d9ae70d14799cceb178cd89ecaa743a063324ab60ca8cfe777b2"
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
