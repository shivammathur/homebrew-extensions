# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xlswriter Extension
class XlswriterAT70 < AbstractPhpExtension
  init
  desc "Xlswriter PHP extension"
  homepage "https://github.com/viest/php-ext-xlswriter"
  url "https://pecl.php.net/get/xlswriter-2.0.3.tgz"
  sha256 "b69c168780527ec73fa3d7986d4279ecce00e184760f6572cc5e450a68b4f201"
  head "https://github.com/viest/php-ext-xlswriter.git", branch: "master"
  license "BSD-2-Clause"

  livecheck do
    url "https://pecl.php.net/rest/r/xlswriter/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "6097c7ca75e3a9fb32fc4756279743d5031a2cd5afbecff91a54bce59eeb24df"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "df2421b9a18784ded5237ef682faa163b0cd83daf1ddc0168f54aade3175fe89"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "17b590c086410213a95f93b57b9d0a7fa4d328d94d2b6c52d85c7a92a90220d6"
    sha256 cellar: :any_skip_relocation, sonoma:        "a7fe73849a82692ffd09c4a2725f0f2b638e1c1f23cdf5d13b219ec4eb4aaa20"
    sha256 cellar: :any,                 arm64_linux:   "2668cbc0f184a46bc0d39153c32eb2238089b4dd3d1510b83deb9b4c5b72ce7b"
    sha256 cellar: :any,                 x86_64_linux:  "8c8706752f7a233014a1e6cbbc43747099b8271d8a3d0d8e30bc9e240e3c7b21"
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
