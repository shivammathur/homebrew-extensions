# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Zstd Extension
class ZstdAT84 < AbstractPhpExtension
  init
  desc "Zstd Extension for PHP"
  homepage "https://github.com/kjdev/php-ext-zstd"
  url "https://pecl.php.net/get/zstd-0.14.0.tgz"
  sha256 "207a87de60e3a9eb7993d2fc1a2ce88f854330ef29d210f552a60eb4cf3db79c"
  head "https://github.com/kjdev/php-ext-zstd.git", branch: "master"
  license "MIT"

  livecheck do
    url "https://pecl.php.net/rest/r/zstd/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia: "2ca720d463c7f1d5553e9ccc283201bab1efbd3563c1cfb1a0d5813fe51397c5"
    sha256 cellar: :any,                 arm64_sonoma:  "f82fdd1a334728302ddc600ab22be69820fe54c58496b0baab4c738d7e343ce2"
    sha256 cellar: :any,                 arm64_ventura: "54da9e3ee50b04bd6c16d74267a8b803de42cb3d83562d6ed1b4f346656202ab"
    sha256 cellar: :any,                 ventura:       "8784eff99d13ba5bf15787d274d7d1201cb1e83ab9ffdd14759d86c064a7be3d"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "ef70fde712a6bd9e94b7464389934be4cea66221be8333848ad6a9c790b8ddd1"
  end

  depends_on "zstd"

  def install
    Dir.chdir "zstd-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", "--with-libzstd", phpconfig
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
