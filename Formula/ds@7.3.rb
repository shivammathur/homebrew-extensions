# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Ds Extension
class DsAT73 < AbstractPhpExtension
  init
  desc "Ds PHP extension"
  homepage "https://github.com/php-ds/ext-ds"
  url "https://pecl.php.net/get/ds-1.6.0.tgz"
  sha256 "7c5eaa693e49f43962fa8afa863c51000dc620048dcf9442453c27ca151e291e"
  head "https://github.com/php-ds/ext-ds.git", branch: "master"
  license "MIT"

  livecheck do
    url "https://pecl.php.net/rest/r/ds/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "3ea6ed0db86f1efb2cf770f12948309ca6d265fe4ba4186b8478f0d4fd02c507"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "4cf8440fd6caf88a830cd0df8ea93452b3fbd32d6bedc69f84bc8d239295ad76"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "fb3cf6d50ecb019de57a74a8d4329d1bc42360b41d4aad65e4a71bbb8ef5e4cf"
    sha256 cellar: :any_skip_relocation, sonoma:        "52438fd446aee0b1238c137be672a5888681770460f0fa7183cb6842ae81e561"
    sha256 cellar: :any_skip_relocation, ventura:       "997f571ad20379a09adf53f821be426e98d469e4abf1d849dddf55c783d6de6e"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "5be732259f20109cb5662c2a7a75366c0c45822d2dd9e6d1f1a8371866c7f681"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "2687f406f7faac6bb833380129e6bc5a661aa90447d934f3cfae4ab0030c529a"
  end

  def install
    Dir.chdir "ds-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-ds"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
