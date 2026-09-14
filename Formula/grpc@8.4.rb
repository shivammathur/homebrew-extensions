# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT84 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.84.0.tgz"
  sha256 "555716233a5cc9a6baa605719f87b7688a88fb8bfdd9b4493396276244d56625"
  head "https://github.com/grpc/grpc.git", branch: "master"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/grpc/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "929dc825b3f2dd7896f23defffb51cc1422b830c8f24818a29767556899c295a"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "20c51517404f87615ad479f5166ea39bcd0315417908bbcc55af8724bd8081b6"
    sha256 cellar: :any,                 arm64_linux:   "56df2e1554af9e8b59e8fd2cae908f4365babcc138ae2f7b015fd1765f9c133b"
    sha256 cellar: :any,                 x86_64_linux:  "2135be42b5237af3a506981b45838ce126880d9e38a496d2285a2c6b1f3d713e"
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
