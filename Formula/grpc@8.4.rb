# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT84 < AbstractPhpExtension
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
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "fa5f2691b2c0be40fc64e9815c65a4a14e79b40ed82c8d04c0512f9856231f10"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "9dd329238add264d45dde3b1a963d94b8c50c1587edfc17e2ca6891c6e6f416a"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "d2a0d915d4254277d7a2ae2196c943dbb8f49eb1af854ab7a72a68520034fec2"
    sha256 cellar: :any_skip_relocation, sonoma:        "817482bf30da7fdc63c764f9c9a4733d2e5e361d3de6b5c5033b492abb090512"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "a85c01b010b20c0d52db05c2cd2b314e0722cb160e28bc526668700e99b535ef"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "e30c7114b679b080a74ba3b2e116ea83b98165ef270e616aac18ff6eb178a2c5"
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
