# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mailparse Extension
class MailparseAT83 < AbstractPhpExtension
  init
  desc "Mailparse PHP extension"
  homepage "https://github.com/php/pecl-mail-mailparse"
  url "https://pecl.php.net/get/mailparse-3.1.9.tgz"
  sha256 "ecb3d3c9dc9f7ce034182d478b724ac3cb02098efc69a39c03534f0b1920922b"
  head "https://github.com/php/pecl-mail-mailparse.git", branch: "master"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/mailparse/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "2925da949ff2c393cedbb7fd9c863f89817da5e0d66fe9c4ca917b5f16c26ef2"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "166488b8d1f33e31138e96621598562ebb330275d6c30ec2b24ebf71c0edc9b2"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "8504c42f2616cfeef7a2bae0f021e295a651b2630b1125455d66fdd392482ce9"
    sha256 cellar: :any_skip_relocation, sonoma:        "6d8bee6b493667df3f7c76806f06a8b5389fbcc6ae7cdd174dd6d57feb0e58f7"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "1fdc9a1ec15c325238bd63e8a78260bf0c1f5506ff6a6cda8b9d00f21b216213"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "e6dbe0d1f9914951f410575cc05f02bb1a036593c3cb4730a331d9d851efe02d"
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
