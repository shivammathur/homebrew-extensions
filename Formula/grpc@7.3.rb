# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT73 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.42.0.tgz"
  sha256 "a7b9092534555ea4ea0ea79c1333afd088569eb5865b941a4a610504e387683a"
  head "https://github.com/grpc/grpc.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "e7b5c4046e75feeb5ee3c6f0c37b187d74efa713617ded94ca48e3fffe19d8bd"
    sha256 cellar: :any_skip_relocation, big_sur:       "8d77387ccf8672900c8a9eb589b1ef0c68108c3717a428aa42da21acf4362c80"
    sha256 cellar: :any_skip_relocation, catalina:      "103c3c4a84e1ef59dd845907ee4a7b14790a6bdc75a22ae6159c68c50eaf1cb2"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "8221a39900adf79a9001807e3441301c9f72f4d91eff441951430408ea45f152"
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
