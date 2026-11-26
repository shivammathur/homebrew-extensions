# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mailparse Extension
class MailparseAT86 < AbstractPhpExtension
  init
  desc "Mailparse PHP extension"
  homepage "https://github.com/php/pecl-mail-mailparse"
  url "https://pecl.php.net/get/mailparse-3.2.1.tgz"
  sha256 "a9f092ae84f32f15149a09a9a278bb20d3794cbfb57893eab4933814d7ab2fd5"
  head "https://github.com/php/pecl-mail-mailparse.git", branch: "master"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/mailparse/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    manifest_sha256 "7c384a0fbe98946ac4d3875d9fec7885d237fe047a3bef0d4b501523ad8cfa35"
    sha256 cellar: :any_skip_relocation, arm64_golden_gate: "7e0476cbcf09f7098cd85f9668275931660d1b08aa60c062799bd4778801c036"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:       "74d7660416ffd32fb7c3f12762658b81a46b9e46b9ea1fb2b7ee132df8ddd4d9"
    sha256 cellar: :any_skip_relocation, arm64_sequoia:     "56a2c8e2a4afaa3ed75247f60b7dc380772f8db4611f4b7d686043d61f4236ae"
    sha256 cellar: :any,                 arm64_linux:       "d15b921120e59c9d722555baee7216e8288a22df9164bee748ca2ab01fb2a010"
    sha256 cellar: :any,                 x86_64_linux:      "cc5fea7f6ce77dcffc378dbcf0230d5597b5f89bdec50c29054fcc71995c27a1"
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
