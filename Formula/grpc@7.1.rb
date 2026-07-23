# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT71 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.83.0.tgz"
  sha256 "b12c7e0e048df728a4f2c513aeaa78ae18ad5c3ab3b607eeae398e0e1bab12ea"
  head "https://github.com/grpc/grpc.git", branch: "master"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/grpc/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "35e4042f1d6cfa13636ef9e8647ece248adec5a9d83ddd051095996516c19647"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "9f103bff5dff955ad90a5e6d812f6a3b2f0d93d88bec047eba84608eec5029fa"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "be053a047ff29e3208cccc4f3c9ac5bd57fde58d3051df923fb5df5fcd1a1a6e"
    sha256 cellar: :any_skip_relocation, sonoma:        "debe4028e2f0cedd492e954864d466822cfd58a285114fa7289f449ab2c87c4c"
    sha256 cellar: :any,                 arm64_linux:   "1172fe9f87b5a6955df7ce63720790b0b1c1166ca8b6824b79391949a75d85fa"
    sha256 cellar: :any,                 x86_64_linux:  "f79cb8b72c0e08a3a6f9b1099b566ce3ef4b4e599464a655eb6183b753aee1b6"
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
