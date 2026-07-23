# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT82 < AbstractPhpExtension
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
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "f2c85c55edd7a22ec8610887869ac2c7265260c86c6877c90a791eff1d1699f7"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "1fe5a8751f12244114b795d6a42e4b314936bb001d3ba8e5da6c1821c743d012"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "03fd9f410b98733a754c768a8fc75073723983251ed2808888a08e4df2a6aaf9"
    sha256 cellar: :any_skip_relocation, sonoma:        "4ca3cea25efc51f2c7ff9c5bb340a3b4813cff2c420de81cb03562d7b92f1917"
    sha256 cellar: :any,                 arm64_linux:   "3de69e4573600f1186ea163c5cbebdf3963481f89d19ebe743304785f67e217b"
    sha256 cellar: :any,                 x86_64_linux:  "bf53a9fcbcea0832f17142ea1980a2618cdc0b438ed4d2fe1b369cf3b9556821"
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
