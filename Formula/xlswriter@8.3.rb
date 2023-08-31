# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xlswriter Extension
class XlswriterAT83 < AbstractPhpExtension
  init
  desc "Xlswriter PHP extension"
  homepage "https://github.com/viest/php-ext-xlswriter"
  url "https://pecl.php.net/get/xlswriter-1.5.5.tgz"
  sha256 "4b8c8aacf48737c0d741a2401f4c495318ca18879e9bfcef5f698946ef28c671"
  head "https://github.com/viest/php-ext-xlswriter.git", branch: "master"
  license "BSD-2-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 2
    sha256 cellar: :any_skip_relocation, arm64_monterey: "4ef750485e322b69c54177cab9821c7de21e1952821c171647aabf212ccd465a"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "b21da9279a26409b5c98eb1df15ab207c484dec1a9521cb35d6312abbb3a40ed"
    sha256 cellar: :any_skip_relocation, ventura:        "8e71b81db3031184f241b43e62dba6cf0004b26457f0cb3eff054f76ecaf6d4e"
    sha256 cellar: :any_skip_relocation, monterey:       "f99dca64ef273fa9f036cf3bf66d568f1e299fa4cad2c3cf87a710c7305d4aaa"
    sha256 cellar: :any_skip_relocation, big_sur:        "96758baae0b7d9b4925944e766f19bb36b33bcd27c8d496f960c5e5e61efa1c3"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "e2a1528521c3bf1642c13f0a1b8679f5033fb9c9173e8348a4a20cf422336aee"
  end

  def install
    args = %w[
      --with-xlswriter
      --enable-reader
    ]
    Dir.chdir "xlswriter-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
