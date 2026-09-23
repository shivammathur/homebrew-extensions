# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mailparse Extension
class MailparseAT87 < AbstractPhpExtension
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
    sha256 cellar: :any_skip_relocation, arm64_golden_gate: "2952ac7ad4404d9edace33f7625a66f9f8ed4743e8bc44bdde091f7e0ff24b06"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:       "cd3d192ad65e7df23fcb213208e841baf06bcc5fa38e0fc52ce670dbedbe1cd5"
    sha256 cellar: :any_skip_relocation, arm64_sequoia:     "3622f4d7289333970d938f85c4851844940c57167726464d23ecda126e6bd945"
    sha256 cellar: :any,                 arm64_linux:       "3ec51ae7b97b57f5c64bcb306c8262410d1505bb40d30cba1e8353a7d555af1f"
    sha256 cellar: :any,                 x86_64_linux:      "87c346f25f16222b4b4d3b37a89788f762c62110449017a49ad4823d9a69e7d4"
  end

  depends_on "re2c" => :build

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
