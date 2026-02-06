# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Uploadprogress Extension
class UploadprogressAT82 < AbstractPhpExtension
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
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "08ab3883b389736d01d5a071b94307f20213ef38d86773d372637c32ba9b1898"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "4a3f1d6aa7aa9e6b63ff9078a7855945ec9a9ceda440f13bc25c547db2774a12"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "8d4c5656d2be4d185e85d8b8c360add5a58f1c6fb1fdad9238ba5df3a740f411"
    sha256 cellar: :any_skip_relocation, sonoma:        "f4f960785d63bdacad2ac417ed4dd0cde9d71ef8b508554311fe83974bff4572"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "56f4e47f14ccbb626bfd0b2dd397acb2e2fa44c61be9843e31932f238d8743fe"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "84e59a4ceabc7d2c15563c19d339a9b946e302bae6c37bc63df9474cb27a3020"
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
