# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT83 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.75.0.tgz"
  sha256 "d2fa2d09bb12472fd716db1f6d637375e02dfa2b6923d7812ff52554ce365ba1"
  head "https://github.com/grpc/grpc.git", branch: "master"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/grpc/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "2f59d8612818a1bcf53f5e48466e0620408d454d7c3c947499ae2e1ccb46cd77"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "b57dcf1883800692b9cbe0777bd1f11b9124d54761b8b17066fe1f89203ff476"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "5117745d7e64975e114d0f2887c5df31862e0e5963049e2ff89f8799b5c18a3a"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "0567ea3e6f94e25da0ab9c736af769458fb16c63404d8682224683dbc6d75207"
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
