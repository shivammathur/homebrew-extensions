# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mailparse Extension
class MailparseAT84 < AbstractPhpExtension
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
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "f9d1e03d590f9ae15358b42381809697987b3a950faf294bb4dd02ffa8f3b782"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "49b3eba75904abd78aaf7e14201bacc578b658eabb158e71cb33ad1abe358dbe"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "79c5fe896acac27f929287c1e792250eb81ed6c10a8c8643d3ff236acf364241"
    sha256 cellar: :any_skip_relocation, ventura:       "e7a0d453f257bf8180c0753afa17723af166456d61cfb33d53a5fdff0dd59ae4"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "8ea38bf7b69a2e6635e2d0348b8f9891876f3a7f433fa24eb10c1cbdbd382fa5"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "b76f96f7db9d7e8a00064c6561682ebb7444ab4b18490f523de6b43614e49076"
  end

  def install
    # Work around configure issues with Xcode 16
    ENV.append "CFLAGS", "-Wno-implicit-function-declaration"

    Dir.chdir "mailparse-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-mailparse"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
