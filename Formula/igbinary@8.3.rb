# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Igbinary Extension
class IgbinaryAT83 < AbstractPhpExtension
  init
  desc "Igbinary PHP extension"
  homepage "https://github.com/igbinary/igbinary"
  url "https://github.com/igbinary/igbinary/archive/3.2.14.tar.gz"
  sha256 "3dd62637667bee9328b3861c7dddc754a08ba95775d7b57573eadc5e39f95ac6"
  head "https://github.com/igbinary/igbinary.git", branch: "master"
  license "BSD-3-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 2
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "fac3c9760d31c648609e5e53f7d62cfd97229ab4d1143cbe4f96c91a71a681a0"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "7b7a52ea7d1de63f1e7d09181790167addde1a875cda3ab8c437818682089f8c"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "408ef24e839a86e82ec0ed5bfa028df85f7faa03182653f4f65f61aff00458dc"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "e375a8d75604819003c931936ccf598dc38bced55d3b755760c7170f76af7242"
    sha256 cellar: :any_skip_relocation, ventura:        "0a1256daf1d1a45cfc08223d299ae26363ca9a8b97434e3e63d230aae58f657e"
    sha256 cellar: :any_skip_relocation, monterey:       "817ef0f9db39cf9c0c6a25e7e242f28a7116ff0d27d5e4163cab702f569eeb9d"
    sha256 cellar: :any_skip_relocation, big_sur:        "54fa9dccc1acfc4b53279e6af9972d4d405c5cfce922851f93ad84baf3dd5141"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "b90a4e6ec4f9a0875b921ec105841694fe28b7fa569cf4be973d52623b53882b"
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
