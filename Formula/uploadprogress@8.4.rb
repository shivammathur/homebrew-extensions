# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Uploadprogress Extension
class UploadprogressAT84 < AbstractPhpExtension
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
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "57fea3fa7f2cb1c65e3b558b3cdd9ea558713d9070d0cd999275c3260cc10e10"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "432f2a0cae8ad4d0a3ae5bffca7eaa9c5d24f477e0d01cfdbc2497e36a49f63b"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "5771202fa4969ecc1272283f411302a0d5011859a23e14b74ed3d112fb167395"
    sha256 cellar: :any_skip_relocation, sonoma:        "987604438790495547b330d2f09903dec7b2719dfd1983f118231846ab3c20d6"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "e1e2bec525d71adddeda431ac3edc15554a84fb5824b482406f3bdb236236449"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "6bb8aa8e4113d258c7410447251379ac3cdb1f852c75da34235c91a83368d917"
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
