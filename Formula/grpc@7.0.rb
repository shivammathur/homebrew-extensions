# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT70 < AbstractPhpExtension
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
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "47ad9017b3d495fe8392bf0e2a2d4b74b035a0a107c4dc5815ab9910ed5abb7a"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "7d2f270ecc878b805bc57c4e5c375cc644c441602967818df96dfc74889704e9"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "3e2e41345c7e341feb26ad63658e91d927b17b53be1016dbaecc2b4f23d8f933"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "d22b37bd7fccc7edd29436c55d1195d8af0590fdf0fbe00a093791f5b51d51cc"
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
