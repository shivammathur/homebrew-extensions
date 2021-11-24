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
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "126d1d0ebb791ad583bda93f9c563635061f26130b201fd99f4317337b9bcb53"
    sha256 cellar: :any_skip_relocation, big_sur:       "f2d129a529206b7175a5c194b8b0b7806f972e999ea9ccd59abe28c2d96c9399"
    sha256 cellar: :any_skip_relocation, catalina:      "72a9665dc66899fd8816b3df5c86d1b2d1e429a860c9af6485fb8af7c9685223"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "1d6b60431036521b9561653ddd7b80c77a54322ca7b65bccec9b6106704adbc6"
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
