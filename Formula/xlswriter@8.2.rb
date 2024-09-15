# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xlswriter Extension
class XlswriterAT82 < AbstractPhpExtension
  init
  desc "Xlswriter PHP extension"
  homepage "https://github.com/viest/php-ext-xlswriter"
  url "https://pecl.php.net/get/xlswriter-1.5.7.tgz"
  sha256 "3736aab69aea238dc80fbb385fcb2a878a78fa9460551cf633e119f3854086ef"
  head "https://github.com/viest/php-ext-xlswriter.git"
  license "BSD-2-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sequoia:  "f8351ca84e26a31a3c8e1e0986b84892d546eda0f6741a71f80587e7ef0bf495"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "44b793357054cdcdf0ff34d11946170a63de3a7bf50f1e01b3af738195d8ca96"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "65cdf7d09427d40180dc15bfad915eb08de7dd6c259e505b25aeec7aa38214c1"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "cf891e477cc4761e1e0c026e8c91038e23b640fa0b05d3133f955759a2cb097a"
    sha256 cellar: :any_skip_relocation, ventura:        "0c60a6da520105c1855d3e5a26ba80d1c8ecb5fe373f4a00bc1ea251c981252e"
    sha256 cellar: :any_skip_relocation, monterey:       "c7dd345362bbb66fe7b99491ed0159ab2eb894cdc8903d614f0450742804c9e6"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "b94a0a23c24c0ffa3e78af2c31cfaaf1b8ce379a0f3489c445b0f05b373a26d1"
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
