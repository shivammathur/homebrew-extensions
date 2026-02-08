# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Pdo Firebird Extension
class PdoFirebirdAT70 < AbstractPhpExtension
  env :std

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "217e717a3f197e69d98328bf60d242934b0096d545fab9533261da993fbb19c6"
    sha256 cellar: :any,                 arm64_sequoia: "90f2505091cc69f4121fef30b9ed1dcafac76d96dff05a90c5e565bc1fdd26a4"
    sha256 cellar: :any,                 arm64_sonoma:  "846421df00fde5f956fe88fa48c5a8b420683d19e853032263d0b3ff71602e1c"
    sha256 cellar: :any,                 sonoma:        "8618b1fd5a1e53d54275dbd7ef4e19e9f337276cc5adff6cd206d30c0ca77818"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "858eba7b536c410da48b90bbe0341ff5ef130f5b40011327c4f87ff4d3a37753"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "8e646f2ed34487517ed95a5c47e02a8c8dd7c16d59e3b16228d782468b61e56d"
  end
  init
  desc "PDO Firebird PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/4de530c8e7f4d5fa3df1d0e15d79a7bd44cc597c.tar.gz"
  version "7.0.33"
  sha256 "3371c5712eae64aa28eda7733a02d93ec298894d57eb0ce3fdac0904bbee4a16"
  license "PHP-3.01"
  depends_on "shivammathur/extensions/firebird-client@3"

  def install
    fb_prefix = Formula["shivammathur/extensions/firebird-client@3"].opt_prefix
    args = %W[
      --with-pdo-firebird=shared,#{fb_prefix}
    ]
    Dir.chdir buildpath/"ext/pdo_firebird" do
      safe_phpize
      ENV.append "CFLAGS", "-Wno-incompatible-function-pointer-types"
      system "./configure", "--prefix=#{prefix}", phpconfig, *args
      system "make"
      prefix.install "modules/#{extension}.so"
      write_config_file
      add_include_files
    end
  end
end
