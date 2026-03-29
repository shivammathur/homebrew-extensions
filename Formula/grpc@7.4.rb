# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT74 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.80.0.tgz"
  sha256 "75e553f2b5c3f7dde99aa984a9601dce6db240bc3c85d7fe09298b5bd8c5d53f"
  head "https://github.com/grpc/grpc.git", branch: "master"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/grpc/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "56a87b8ff06bfda31911eaf76976118284c8669d913c67a333640e97aa26c38a"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "850e74b87421531154613a2215f0f9fdda961c969ba99d7220a6ba56ffbaa131"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "204b7400924cee1b5199889ec94a424200e71e6a09369ec13610be061bdba8dd"
    sha256 cellar: :any_skip_relocation, sonoma:        "4e33973795b2e8724da91f6013b15cf746030abb7d56f25e19c7414fe0f828f9"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "ac976f62e02bfac7be8ffceb71e53d8fba87a0b200a1daa9fca72205f2cdabd1"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "ddeb305876a90433bb89c3f44825f83c19633dc586beb1d0a686c8eea6c10531"
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
