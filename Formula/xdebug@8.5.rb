# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xdebug Extension
class XdebugAT85 < AbstractPhpExtension
  init
  desc "Xdebug PHP extension"
  homepage "https://github.com/xdebug/xdebug"
  url "https://github.com/xdebug/xdebug/archive/3.5.0.tar.gz"
  sha256 "b10d27bc09f242004474f4cdb3736a27b0dae3f41a9bc92259493fc019f97d10"
  head "https://github.com/xdebug/xdebug.git", branch: "master"
  license "PHP-3.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256                               arm64_tahoe:   "f081cde6a5d2da435c482ee8eddfe2c803757e483a00b1e7ab6aad880a907383"
    sha256                               arm64_sequoia: "ee4ff196b1a839b601c5dd2fee3212dd225d6363a7047068a282edbe0784f501"
    sha256                               arm64_sonoma:  "4f7993b3f21ad25ceb29c91e2d34aaa57047d590b21c0a173eafaf44c37566f9"
    sha256 cellar: :any_skip_relocation, sonoma:        "c4ec42a7e809e497da51118178453ad81a229d7567ff5936332206534dc22df9"
    sha256                               arm64_linux:   "96ef8eca6e59c1aecfb80ba6026d4ba599cc6d6b945a81240ee474586927df6d"
    sha256                               x86_64_linux:  "c0762421d08649b1aa5c6e4ca666f8097fc30c22db2fce5128f174047528b9b8"
  end

  uses_from_macos "zlib"

  def install
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-xdebug"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
