# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT81 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.71.0.tgz"
  sha256 "da142bcf578ec9ce5340fdfaf92633f6589b89885bbf77c5910fd89e244aa4c2"
  head "https://github.com/grpc/grpc.git"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/grpc/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "39018489cb197fd4c374fc454340754b94fd3b7e28e632e820542f7378e3a74c"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "7bc236ae795c37edb5fc60357af9d24d6e2098141b53b1c6d09fadea62ef58e2"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "b8829fe1b00a5c98693396e3b5a748b3e0efb1e9c531058920fd2a05f5afe9e2"
    sha256 cellar: :any_skip_relocation, ventura:       "e03c0f3088ebfaa0c9f0f0c5bbdd0caadfbdf4f085be85535c1add87937d8c35"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "a4f68deb2b07a2c65d85062bb2c252cdb20e554d47a2b326fbe0ee1fbdbbe25c"
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
