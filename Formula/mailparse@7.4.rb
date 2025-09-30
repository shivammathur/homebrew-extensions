# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mailparse Extension
class MailparseAT74 < AbstractPhpExtension
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
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "637ae91a5959be6c1dcbdfc19493a76e34f28852e0e24d86b3713881f7064a5f"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "1ec85639a09d99e26b878f5270045394604d638751dc0ec2571f037de9a4cf6e"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "5970f9eb28e941bb5a1a4f060c36d885f2cd3bdf1aad24769ad1c68d3290de08"
    sha256 cellar: :any_skip_relocation, sonoma:        "5906b7bace2c26c83febca6a2abe4516e5d76d90bf46bc969b41493cb55fc056"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "5e8d147fd51922a24eaef3513c0d5587c08bf1008c49c8887758f33e2b416d8f"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "d5d84a497ff72536b5925c3b15fcf408bbbdc6fc93b1bf869ad477f1d6bff500"
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
