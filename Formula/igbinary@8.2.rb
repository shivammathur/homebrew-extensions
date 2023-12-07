# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Igbinary Extension
class IgbinaryAT82 < AbstractPhpExtension
  init
  desc "Igbinary PHP extension"
  homepage "https://github.com/igbinary/igbinary"
  url "https://github.com/igbinary/igbinary/archive/3.2.15.tar.gz"
  sha256 "6fcbd7813eea1dfe00ec72a672cedb1d1cce06b2f23ab3cb148fa5e3edfa3994"
  head "https://github.com/igbinary/igbinary.git"
  license "BSD-3-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "1da00be1cb012477626a3ce24a5eb080529c3005aa4769427fe7dec28683d4a6"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "8d46f9894721826f984338ec5095f347e1c76eea518c0662f29811c388d4982a"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "c017557dfe4bc3d367c700972820f77621c7766a92c2b3585e10860e98e5ba9e"
    sha256 cellar: :any_skip_relocation, ventura:        "6687df470fbe599eb33c161e17b717415c8e65b57c131f5da4a2fd8e7c8dc0a2"
    sha256 cellar: :any_skip_relocation, monterey:       "383457e3bd8dae5bfe6f844bb79f69eff707aa965f6e5c7974850e495a189ee5"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "6b9ff8bcc32cf4905cf70a7f57e946ac2a8123eb116b11c218124240cacc22eb"
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
