# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT81 < AbstractPhpExtension
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
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "5e6b7d2efd92a505aa3f183bb835f66d9b56a2bf1244b3ef3709ad3d9bb400e2"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "914a45bf1525f73aa555eb5ed2d33e42aa2904895ae448b4f77cb49f71ce52b6"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "5eda0c538da47eda4c072380f9e30719ec13dd8d3e140bb9ebfdaeb8650b6a03"
    sha256 cellar: :any_skip_relocation, ventura:       "adf24391b5f2a2b9e4114d39f9ebbee924eea909178fec133d35399b8db3904c"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "bcd1e6dac0531e226132a9672af3b5bed49b06f51b234fbc6958c06e9981022d"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "1b9ddb682ebca985726b7a3160a2ca721e7935ed46900ed63f9aa79267bac20e"
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
