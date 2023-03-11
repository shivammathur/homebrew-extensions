# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xlswriter Extension
class XlswriterAT82 < AbstractPhpExtension
  init
  desc "Xlswriter PHP extension"
  homepage "https://github.com/viest/php-ext-xlswriter"
  url "https://pecl.php.net/get/xlswriter-1.5.4.tgz"
  sha256 "6df4198ac50366317bbecdfd08d34047cff517465be48261849f50b833da0b73"
  head "https://github.com/viest/php-ext-xlswriter.git"
  license "BSD-2-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 3
    sha256 cellar: :any_skip_relocation, arm64_monterey: "154fc207b51c8545efe118a48d92404ac3cf56f15cd44f8e0e1cf06ba7882e42"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "e8746a60501c60289068f71923ad3b67c4e7fa726c85b31b86164069b9dd57e0"
    sha256 cellar: :any_skip_relocation, monterey:       "8e5a505341d40993a440cd4adb06733d7cf21c0c98a65ab5686f2f1a969519ac"
    sha256 cellar: :any_skip_relocation, big_sur:        "8a96f0a119c17d85535746e61100c912df5b42866691fb79ee578b334dc73b0f"
    sha256 cellar: :any_skip_relocation, catalina:       "62d216cd85b01539ffdb17eedaf4a2c4e2b967485c7d0b1e434ea56e38e1b3e9"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "9104c590784dca64a03c3fff4549cff0a6257c41a965fafb37bd5249243cd1ad"
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
