# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT83 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.71.0.tgz"
  sha256 "da142bcf578ec9ce5340fdfaf92633f6589b89885bbf77c5910fd89e244aa4c2"
  head "https://github.com/grpc/grpc.git", branch: "master"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/grpc/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "11b834486d82dcb50e5133e4ef5aa34b0f3296f345e64df343eb1ec91ef87a2c"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "8c5af64a2dc9dcc9c2e14fe3c78eca3543f183f0f9bba298eca7582603ac9a13"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "073ada33728f3bd18fc6bd3f670c7ed1bbef47e5f3d1d94c64b5c84bdeb61fb2"
    sha256 cellar: :any_skip_relocation, ventura:       "f60ff69e18b67307eb43f47bc5e74a59f040c68be146e2dfa78cfd4e3f743301"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "f89c98fdb4a2fe14eab5c6d83334a4d28a992529c51e83dcaa72c922da202efa"
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
