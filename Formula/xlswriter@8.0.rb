# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xlswriter Extension
class XlswriterAT80 < AbstractPhpExtension
  init
  desc "Xlswriter PHP extension"
  homepage "https://github.com/viest/php-ext-xlswriter"
  url "https://pecl.php.net/get/xlswriter-2.0.1.tgz"
  sha256 "279749cbe22858af2f69958eeefea3060a2e6545fda1f8fc0fceba0a44f29a20"
  head "https://github.com/viest/php-ext-xlswriter.git", branch: "master"
  license "BSD-2-Clause"

  livecheck do
    url "https://pecl.php.net/rest/r/xlswriter/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "b82eaf0d22f3b81a46a2e5510d999f43d2de2413e943c8f9633def7171cc11c4"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "f69a3e1ab44ea0e7fd17ca24ad406f5601fde889cc1b57da7db4748e862047fd"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "ae8874a7c7ec28df4e52eefa66bcff18d6eeb685a0f1e2955d9129e78a4c547b"
    sha256 cellar: :any_skip_relocation, sonoma:        "0184678287a44c6b6bb0b1ceef6973d7588ee33c45a44e97f0d722d5f9144625"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "96dc0f7b132ea2016c50d903bd86a7f89fe6d67ff232957e35f3a7d79fd345ae"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "952532640906c1f39944a5380ccf27d3ed996c741dbd43d8a33fb0d38cb4050f"
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
