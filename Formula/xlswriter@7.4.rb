# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xlswriter Extension
class XlswriterAT74 < AbstractPhpExtension
  init
  desc "Xlswriter PHP extension"
  homepage "https://github.com/viest/php-ext-xlswriter"
  url "https://pecl.php.net/get/xlswriter-1.5.2.tgz"
  sha256 "fc363ef816c8efc46f9b5f6c86a7ab4469a803659b8d6b46421d143654361ea0"
  head "https://github.com/viest/php-ext-xlswriter.git"
  license "BSD-2-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "9b6c9b583b21d0e54407be3c139bba9c92d3b999335033bcb4c5c2258414f30a"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "b5fa0122b9ce414052dcd86882268da52402f88f274752107a026c9ba28d4761"
    sha256 cellar: :any_skip_relocation, monterey:       "757336bcc1400f93c8f81573469ba0374ae01874dc647d3aed29bfa65e507911"
    sha256 cellar: :any_skip_relocation, big_sur:        "74c3a45d40e7dd740d7d02df2423850cf56f3a60e15dd2d78439b8bdfec106a7"
    sha256 cellar: :any_skip_relocation, catalina:       "7c066639cd6eeb6eae38ffc87dad386ffde7eb044fba08e5b9dd57978365d59c"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "b9333c1c5653afb918ca4ce7c30241715f4fd5f4ec4fde64bd797614f3c4b42b"
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
