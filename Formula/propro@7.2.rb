# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Propro Extension
class ProproAT72 < AbstractPhpExtension
  init
  desc "Propro PHP extension"
  homepage "https://github.com/m6w6/ext-propro"
  url "https://pecl.php.net/get/propro-2.1.0.tgz"
  sha256 "7bba0653d90cd8f61816e13ac6c0f7102b4a16dc4c4e966095a121eeb4ae8271"
  head "https://github.com/m6w6/ext-propro.git"
  license "BSD-2-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any_skip_relocation, arm64_monterey: "63a998383c791935fb5ba564cc7afcfc21fffc82a41995f2feadac3e938f9a58"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "dce20ea8e678bd723b07a3023cb966ba05848c742dea005816ffa60ebb164c37"
    sha256 cellar: :any_skip_relocation, monterey:       "71346962fc3bf8ede99211fcc3fd97a277375030b5039adb2753fda571c2fdd5"
    sha256 cellar: :any_skip_relocation, big_sur:        "1dd9a624a717eb95b747496e52e0edd5a3a5731a74b89a1893e94b5706cfe4df"
    sha256 cellar: :any_skip_relocation, catalina:       "051d4f2d65f2f01ab2ee2477f32012ef39846063ab42e53f8c01960f0996d4fe"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "976ae418014b1549fb81187cf0c4585e3b225a2b02833288c1240be27a38a7d4"
  end

  def install
    Dir.chdir "propro-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-propro"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
