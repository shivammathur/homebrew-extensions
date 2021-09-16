# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT82 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.40.0.tgz"
  sha256 "ebfb1a2e9e8378ab65efb48b2e7d8ff23f5c5514b29f63d9558556ae6436ebf1"
  head "https://github.com/grpc/grpc.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "11bb8cb945ee1aad8e5ab57affb7934b5b88acc220956f184e4bae6f358fcaa0"
    sha256 cellar: :any_skip_relocation, big_sur:       "dd1fae45205e24a9b727de648565dec85d191686a2d01ffc16dd35639cc99f47"
    sha256 cellar: :any_skip_relocation, catalina:      "e5538dbb45bcbf8750ae7b297fb34a890ad3439b81f99b1e8814670076692b0c"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "ee52135b112b32fec3e270313ff21bed8cf5d434bdd6cd8e2b663ca5cc8106cc"
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
