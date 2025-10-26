# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

class SpxAT74 < AbstractPhpExtension
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
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "dba8469c871537f64db68a0646ecb316675eaff28b10e5540a34846aea93effc"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "26b88541f4b3df7063da282344924a7ee6caa409aefcfff4765459555fe01b22"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "ca94dbe5da5cd728d22f6d2b70ab2e63b7588d4f6852c799534010e5d1b8971e"
    sha256 cellar: :any_skip_relocation, sonoma:        "d09f5aaeb894c947401ddcd55411a7efb9e07ee400f90cd2dc897a973acd114c"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "c4f63d6ba2c109172607bd16a3ce519a792466109155b2e324a4b6c78055f9c9"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "87e2158e12115b40cdfbed6f4a9c9239f1fc51cc7f3c51396f9f99328cd8a77c"
  end

  depends_on "zlib"

  def install
    args = %W[
      --enable-spx
      --with-zlib-dir=#{Formula["zlib"].opt_prefix}
    ]
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
