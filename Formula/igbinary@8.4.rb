# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Igbinary Extension
class IgbinaryAT84 < AbstractPhpExtension
  init
  desc "Igbinary PHP extension"
  homepage "https://github.com/igbinary/igbinary"
  url "https://github.com/igbinary/igbinary/archive/3.2.15.tar.gz"
  sha256 "6fcbd7813eea1dfe00ec72a672cedb1d1cce06b2f23ab3cb148fa5e3edfa3994"
  head "https://github.com/igbinary/igbinary.git", branch: "master"
  license "BSD-3-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "693f1902cf4773f414c5ee5355f8e9a6a69bb63fc8902d7240c0ed34808183d8"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "e86c6fc51d767f023c91c6a94f39ddd7778a4b5f443739836e22737fbf0c222f"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "6e1ed47d9e38aa20ef8fa972cd913f8f496a90cb0955e9e81fccc4d017f62606"
    sha256 cellar: :any_skip_relocation, ventura:        "1f4e9b220cd553ba3c7d833ab000fff1574b8c578c2aab34fbe9671573e1ab9c"
    sha256 cellar: :any_skip_relocation, monterey:       "c78ea986a08446f04fa2539a4d3250e776d50ef405413c3e0727250f19d010dc"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "55a8bdeb6197b356103696b64424ca1880a51de74898b49376f511a20a3c9dd2"
  end

  def install
    patch_spl_symbols
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-igbinary"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    Dir.chdir "src/php7"
    add_include_files
  end
end
