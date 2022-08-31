# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xlswriter Extension
class XlswriterAT83 < AbstractPhpExtension
  init
  desc "Xlswriter PHP extension"
  homepage "https://github.com/viest/php-ext-xlswriter"
  url "https://pecl.php.net/get/xlswriter-1.5.2.tgz"
  sha256 "fc363ef816c8efc46f9b5f6c86a7ab4469a803659b8d6b46421d143654361ea0"
  head "https://github.com/viest/php-ext-xlswriter.git", branch: "master"
  license "BSD-2-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "c7b854ef978fa6b347c906d9e583a4e5d79670ee9adefcee8bafb42d488c6274"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "96486803562b3e39437a357d48a8f09b16645475822daabc3ff8623d5717efeb"
    sha256 cellar: :any_skip_relocation, monterey:       "bb5e4b7671ceb2b91ca28f12ee62aa3341dfad3e69338140c8deaaba926b6f07"
    sha256 cellar: :any_skip_relocation, big_sur:        "6aaf1b329e981c13bf986a2cbbb5f222c685677fbfe2c5101a80267f5f2f19b9"
    sha256 cellar: :any_skip_relocation, catalina:       "833ab18fbcfb50a9b73d6caaf01a227466359a3dfc22513f9a105921b970bdd0"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "33d381709ca5b4873621f36d902538d621df9236f345e00dbbb469793f5b8f62"
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
