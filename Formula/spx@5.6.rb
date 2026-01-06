# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

class SpxAT56 < AbstractPhpExtension
  init
  desc "SPX is a simple & straight-forward PHP profiler"
  homepage "https://github.com/NoiseByNorthwest/php-spx"
  url "https://github.com/NoiseByNorthwest/php-spx/archive/refs/tags/v0.4.22.tar.gz"
  sha256 "6f89addd100d3d71168c094612eb8e1c06fd8062da6ee4d9df5b31bdfc4de160"
  head "https://github.com/NoiseByNorthwest/php-spx.git", branch: "master"
  license "GPL-3.0-or-later"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "85620df1e70259764ab7f4993f7b8f188bae190af982bb4c7463b562a54ddaa6"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "e53c1d15341030047974aafab98a77ebe90cac54481b8a476698b41c3f10e4d1"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "dfb1effac7f233bcac10aae92a13b8201af8c3da1598ee34d9910ad638bd3e4f"
    sha256 cellar: :any_skip_relocation, sonoma:        "2c2029de876f8a299be74d92e44aa74679b5d6e0c9c14d69454d28a5113c3e70"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "917ba5bcf18c009152687a23560cd0c7cce8fc478d4e827a452f24847060f51e"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "d74fa390e8404a372b27354a17b4478818698b6ce5430175a576deb131c55a3a"
  end

  depends_on "zlib"

  def install
    args = %W[
      --enable-spx
      --with-zlib-dir=#{Formula["zlib"].opt_prefix}
      --with-spx-assets-dir=#{pkgshare}
    ]
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    system "make", "install-spx-ui-assets"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
