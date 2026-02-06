# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT84 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.78.0.tgz"
  sha256 "c846ac9164930897fea9c55bad52aeb9f99a03cce64e694bd80f781c59baa0a8"
  head "https://github.com/grpc/grpc.git", branch: "master"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/grpc/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "c0bc1e74cbd6786517e10a41d820db5eafdb80e12dea029297b885c43ac42f42"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "12cbb17cc8b7fb2eac14ddf524c8132954321552559bb5c6b00d38724647a7b3"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "35bb678b77325ad0b95e234cd6bb7aa9f806ec8326111e0372fcf634afdcc4be"
    sha256 cellar: :any_skip_relocation, sonoma:        "57969fbbe2a9b79553891b7b59ec85a7744cb69d0969dc190ab0db7da8870c03"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "87ee04f80c6168187e49386e3daabb13cea502b4973a49516b8522b3908ad17d"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "aa3cdf5ffbefe736550a4ccd9aab8f496f4b307d0780edfd992656ee006f20eb"
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
