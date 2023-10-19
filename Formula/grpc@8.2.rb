# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT82 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.59.1.tgz"
  sha256 "d789aab7c791647907c3bc3af2bd6b6e97348d1b50eaa59826be61c4a3c3d3ee"
  head "https://github.com/grpc/grpc.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "3616271194c719c9e8bb938d4011a1eb4daa2ed65a2c530a0a69a47963f6e862"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "b4f6f51e2a6515781b48783623b311a9d8f9ce5c4eb06d3d6d088ba0481fb65d"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "a015e32be058f76a5098547a66e9b0d11e66369b743d98746baa15bdf65dbd00"
    sha256 cellar: :any_skip_relocation, ventura:        "b35056a82125ee29e57e8ed531629bcafce8011ff19f703bd8540cc38789f924"
    sha256 cellar: :any_skip_relocation, monterey:       "a585743ed7884a65c24a7910ef72c50b6b1f49ab3d0b676b86215140913e61d5"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "53813779c06454617df30fbe618a1af663bea93a654a6db1b5fc9298c8205a5d"
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
