# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Uploadprogress Extension
class UploadprogressAT74 < AbstractPhpExtension
  init
  desc "Uploadprogress PHP extension"
  homepage "https://github.com/php/pecl-php-uploadprogress"
  url "https://pecl.php.net/get/uploadprogress-2.0.2.tgz"
  sha256 "2c63ce727340121044365f0fd83babd60dfa785fa5979fae2520b25dad814226"
  head "https://github.com/php/pecl-php-uploadprogress.git", branch: "master"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/uploadprogress/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "fcd78f37ceb75120b32a480e633af57711124d4a8805d0e08e38fdf150d093ba"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "e4230a95dfbbeab1cad800011daa6b2ceb1f7ca04aed300a8d0af3a0320cab47"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "33b89534dbd2c92d6a72f2c9aeb82131e41a3d305f69d7f034738f80aed590db"
    sha256 cellar: :any_skip_relocation, sonoma:        "20c210fa20042b6ab070da630571cd91af62495f90a098fdea31d6d17a6927eb"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "ee2acb4dca8c5c0d24db90446e7bd7d8e38a4f804b7ef2ecb11791107c5fccda"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "a5cb296f093075226a0cc86b880d444a71f2936c2dd404f9df54a8f81ae2fe14"
  end

  def install
    Dir.chdir "uploadprogress-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-uploadprogress"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
