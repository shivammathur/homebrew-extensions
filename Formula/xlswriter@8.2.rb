# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xlswriter Extension
class XlswriterAT82 < AbstractPhpExtension
  init
  desc "Xlswriter PHP extension"
  homepage "https://github.com/viest/php-ext-xlswriter"
  url "https://pecl.php.net/get/xlswriter-1.5.6.tgz"
  sha256 "b05b58803ea4a45f51f8344e8b99b15aff6adb76e8ab4c0653b6bf188d3b315f"
  head "https://github.com/viest/php-ext-xlswriter.git"
  license "BSD-2-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "14caaa103dfa6aa4424d860d03d45a5e994ddc24186f7609286701183086865e"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "de59e148ae8be76a7718bc14023579a93416170247394ee2f4246af1dbe6769b"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "20444c08572fd4115f0dedd08d2bf93e34428308f7929ee4394d903dff27304e"
    sha256 cellar: :any_skip_relocation, ventura:        "bf62c1907cb9f8f4c2c4923f1a49fb082bd2e4e9528cfbedb39cd058d63070ba"
    sha256 cellar: :any_skip_relocation, monterey:       "dba146aa0e0bcbfa213e625e818c2331eecb9220174eb123af37781c91712111"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "107164e1c0c1c9be5892eb45bbc5fa0e7b4febd2c28b91dda9f38578e1f76ec1"
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
