# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Ds Extension
class DsAT81 < AbstractPhpExtension
  init
  desc "Ds PHP extension"
  homepage "https://github.com/php-ds/ext-ds"
  url "https://pecl.php.net/get/ds-1.5.0.tgz"
  sha256 "2b2b45d609ca0958bda52098581ecbab2de749e0b3934d729de61a59226718b0"
  head "https://github.com/php-ds/ext-ds.git"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "22a65c32cbb043790dfa549b8941795fda2b9e6df9e4e211d69e33c25551b75f"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "4802c60e38bee695d2a8c65900e2420d6a247db30bdc63832d30cf0efc985bd3"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "ae0170f17a983197ce7bb0594aa6e7613f7d7aefe1d8b1921b7089881289c18e"
    sha256 cellar: :any_skip_relocation, ventura:        "343337caedddac62dfca419a7a32f6a4fc23cff794e7a1d283fec490e5b0f3d6"
    sha256 cellar: :any_skip_relocation, monterey:       "dc85a0efc7116ac0552dbafd37d0a6f5cb7334b5aefafbbbf9e22a59bcbc36f7"
    sha256 cellar: :any_skip_relocation, big_sur:        "ef8a2467bf62cf834532f3be8f0bb6f831f51600ffa2f0f4466880ad7998c7ad"
    sha256 cellar: :any_skip_relocation, catalina:       "ab4d57835e316b887bcdad68a0255d02f7c4c72788cbbcfc5f83fc64b728d778"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "44057bc1d9fd23236c94028ee27b6214901a1cae736cd8a24f6b067b0749ca3d"
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
