# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT70 < AbstractPhp70Extension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.36.0.tgz"
  sha256 "819becd24872b95c52ad1f022ca71f6f5eed207605b19a26e479b1d5a62c8561"
  head "https://github.com/grpc/grpc.git"
  license "Apache-2.0"

  bottle do
    root_url "https://dl.bintray.com/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "7b06b564c457de3d8c259c7f1aab753acada82c81533d1a026f5ab659aa3f7a9"
    sha256 cellar: :any_skip_relocation, big_sur:       "11a89373f5daac46f0eb7dd439e5170ba9bce151527a7d5f2f907ab6f8e9c2f9"
    sha256 cellar: :any_skip_relocation, catalina:      "a5b9fc5acba6e7cbfc0c4ea90650cc8140c9c5529dcbdb3db59f5a542ced8115"
  end

  depends_on "grpc"

  def install
    Dir.chdir "grpc-#{version}"
    safe_phpize
    system "./configure", "--enable-grpc"
    system "make"
    prefix.install "modules/#{module_name}.so"
    write_config_file
  end
end
