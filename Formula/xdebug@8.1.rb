# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xdebug Extension
class XdebugAT81 < AbstractPhpExtension
  init
  desc "Xdebug PHP extension"
  homepage "https://github.com/xdebug/xdebug"
  url "https://github.com/xdebug/xdebug/archive/3.4.7.tar.gz"
  sha256 "6959726ee2bb99efd660796736801b198ec0847b6360230a8143ad5e2d2063c2"
  head "https://github.com/xdebug/xdebug.git", branch: "master"
  license "PHP-3.0"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256                               arm64_tahoe:   "1e4f4a4041cf5502c08128625355a8001fa33ab1e183c17d3d26ccdad45e99c3"
    sha256                               arm64_sequoia: "eb20975b23424ded6bc96692db242b8b207e9d2a8afcbd576488b1820c371727"
    sha256                               arm64_sonoma:  "522cfc79aae683dec063fab89a3457cdf20fcb76cf82976afa51c10167c2cbda"
    sha256 cellar: :any_skip_relocation, sonoma:        "92ecb7f455d10ca525030350a2b7a90c0678a1264132c475e87cb823b3517ea8"
    sha256                               arm64_linux:   "e5ce2b7137308625f9373725013b380a4538eb6ab42cc1439f54046973af7e3f"
    sha256                               x86_64_linux:  "178a6d43075dd67e2a27b98e282b15d8cbb68456e0a84af9b7950a5f61e7c617"
  end

  uses_from_macos "zlib"

  def install
    patch_spl_symbols
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-xdebug"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
