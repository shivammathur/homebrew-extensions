# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mailparse Extension
class MailparseAT81 < AbstractPhpExtension
  init
  desc "Mailparse PHP extension"
  homepage "https://github.com/php/pecl-mail-mailparse"
  url "https://pecl.php.net/get/mailparse-3.2.0.tgz"
  sha256 "cc5111ae17bfa36efcc5ef23dcf75b6501593ac264c196aad3e39cd4ad765332"
  head "https://github.com/php/pecl-mail-mailparse.git", branch: "master"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/mailparse/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "48d6d6ac20c5d585203cf476e47280e52987b94e6c976ee9b59b37d2bbca97a9"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "ae5a01e76fcd144bd332f836165f22b79ea367b1d6728a211779dc70821c0456"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "2862c79eb180bcac645f023078a4a1e83bf0e4517058f9788f65cbf17c82093f"
    sha256 cellar: :any_skip_relocation, sonoma:        "8787593e7425ac315bc7fe08062f0ea1e72604f5a8576fc735eb9f5ead0b9710"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "870ea2ffe064a6665bc3db26d6f1454fe92de7af5107fd82b32cdcaf23c2769e"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "394d946fcf79f8f9193d201e1983a6416b1ba1f2d19a5f9042b68b1f9d68484b"
  end

  def install
    Dir.chdir "mailparse-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-mailparse"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
