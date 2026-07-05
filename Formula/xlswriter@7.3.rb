# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xlswriter Extension
class XlswriterAT73 < AbstractPhpExtension
  init
  desc "Xlswriter PHP extension"
  homepage "https://github.com/viest/php-ext-xlswriter"
  url "https://pecl.php.net/get/xlswriter-3.0.0.tgz"
  sha256 "a17986ad5ac09529513fc59b2871ca2b53eaec1c2c55cf00be60a292e85ade73"
  head "https://github.com/viest/php-ext-xlswriter.git", branch: "master"
  license "BSD-2-Clause"

  livecheck do
    url "https://pecl.php.net/rest/r/xlswriter/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "f8db9d193e4021dc0eec0e81cf8b2df01373020328b40aebf6573b13e5272970"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "edf38143ebb84fc5e64e23bb3f2e1cc5c8839558b6f978a84a80cd5c3f2fca81"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "41aee789bfd09cab749484115802af7bd61166621e1febaf46a5eedbb1859867"
    sha256 cellar: :any_skip_relocation, sonoma:        "3426af7b0bb2019ff9f5e2b8c7eb3459be031d1a79daf0870794affc64d4c199"
    sha256 cellar: :any,                 arm64_linux:   "a7ade6b171e8fd5eaa012369501ddf48c5c75171e9d024b11fd22c88d32497c6"
    sha256 cellar: :any,                 x86_64_linux:  "ff749d8626ea738ee68a1bb7c7d8e52e1cdb662fec52dc2a472169c0c4171a36"
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
