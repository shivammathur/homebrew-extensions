# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xlswriter Extension
class XlswriterAT73 < AbstractPhpExtension
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
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "8b184ebb820f935f1f02f6073f3d62bf107dacb0f3cebf00b8e0b37488890be5"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "758ce24f10f133647fcdf403f3301121c2874221bdf98718daf8b51af155ad09"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "c02285ce90093d74b3acb868dde15dc23c48c4775b6b787cd9278e8dcd91d0ec"
    sha256 cellar: :any_skip_relocation, sonoma:        "cc9e1f8f73ae1fd18876f7a2d51de296f5bea4f4ae117593456c3c8f5a85280d"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "5c65d57a2ebfa699fe9d9b6ea7cd99c9dbd8fed411a5ddb73479f489e405d70f"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "12736252ccb2cff01c19cb205fef2c0f84ceb2006dda8b7611e614bafb04831c"
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
